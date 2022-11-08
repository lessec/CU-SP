package user;

public class User {
    private String userID;
    private String userPassword;
    private String userName;
    private String userGender;
    private String userEmail;
    private String userSalt;
    private int userFail;
    private int userLock;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserSalt() {
        return userSalt;
    }

    public void setUserSalt(String userSalt) {
        this.userSalt = userSalt;
    }

    public int getUserFail() {
        return userFail;
    }

    public void setUserFail(int userFail) {
        this.userFail = userFail;
    }

    public int getUserLock() {
        return userLock;
    }

    public void setUserLock(int userLock) {
        this.userLock = userLock;
    }
}
