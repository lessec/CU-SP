package user;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.*;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/BBS";
            String dbID = "adot";
            String dbPassword = "roMin2048256!";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword, userSalt, userFail, userLock FROM USER WHERE userID = ?";
        // Protect SQL injection: ?
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            boolean checkID = rs.next();
            if (!checkID) {
                return -1; // Can not find ID
            } else {
                int checkLock = rs.getInt(4);
                boolean check = (checkLock == 1);
                if (check) {
                    return -3;
                }
                String Salt = rs.getString(2);
                String Password = userPassword; // Password hashing
                MessageDigest md = MessageDigest.getInstance("SHA-256"); // Use SHA-256 for hashing
                for (int i = 0; i < 1000; i++) { // key-stretching
                    String temp = Password + Salt; // Combine password and salt to create a new string
                    md.update(temp.getBytes()); // Hash the string of temp and store it in md
                    Password = Byte_to_String(md.digest()); // Get the digest of the md object and update the password
                }
                if (rs.getString(1).equals(Password)) { // fix userFail value to 0
                    String fail;
                    fail = "UPDATE USER SET userFail = 0 WHERE userID = ?";
                    pstmt = conn.prepareStatement(fail);
                    pstmt.setString(1, userID);
                    pstmt.executeUpdate();
                    return 1; // Access granted
                } else {
                    if (rs.getInt(3) == 2) { // Brute-force -> Locked login if 3 wrong times
                        String fail;
                        fail = "UPDATE USER SET userFail = 0 WHERE userID = ?";
                        pstmt = conn.prepareStatement(fail);
                        pstmt.setString(1, userID);
                        pstmt.executeUpdate();
                        String lock = "UPDATE USER SET userLock = 1 WHERE userID = ?";
                        pstmt = conn.prepareStatement(lock);
                        pstmt.setString(1, userID);
                    } else {
                        int count = rs.getInt(3) + 1; // Login fail (userFail value) counting +1
                        String fail;
                        fail = "UPDATE USER SET userFail = ? WHERE userID = ?";
                        pstmt = conn.prepareStatement(fail);
                        pstmt.setInt(1, count);
                        pstmt.setString(2, userID);
                    }
                    pstmt.executeUpdate();
                    return 0; // Password is not correct
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // Database error
    }

    private String Byte_to_String(byte[] temp) {
        StringBuilder sb = new StringBuilder();
        for (byte a : temp) {
            sb.append(String.format("%02x", a)); // Converts a byte value to hexadecimal
        }
        return sb.toString();
    }

    public int join(User user) throws Exception {
        String SQL = "INSERT INTO USER (userID, userPassword, userSalt, userName, userGender, userEmail) VALUES (?, ?, ?, ?, ?, ?)"; // Protect SQL injection
        SecureRandom rnd = new SecureRandom();
        byte[] salt = new byte[20];
        rnd.nextBytes(salt);
        String Salt = Byte_to_String(salt);
        String Password = user.getUserPassword(); // Password hashing
        MessageDigest md = MessageDigest.getInstance("SHA-256"); // Use SHA-256 for hashing
        for (int i = 0; i < 1000; i++) { // key-stretching
            String temp = Password + Salt; // Combine password and salt to create a new string
            md.update(temp.getBytes()); // Hash the string of temp and store it in md
            Password = Byte_to_String(md.digest()); // Get the digest of the md object and update the password
        }
        try { // input on USER table on BBS database
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, Password);
            pstmt.setString(3, Salt);
            pstmt.setString(4, user.getUserName());
            pstmt.setString(5, user.getUserGender());
            pstmt.setString(6, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Already have ID
    }

}