package com.quizapp.model;

/**
 * User model class representing both Admin and Student users
 */
public class User {
    private int id;
    private String username;
    private String passwordHash;
    private String salt;
    private String email;
    private String firstName;
    private String lastName;
    private UserType userType;
    private boolean isActive;
    
    public enum UserType {
        ADMIN, STUDENT
    }
    
    // Constructors
    public User() {}
    
    public User(int id, String username, String email, String firstName, String lastName, UserType userType) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.userType = userType;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    
    public String getSalt() { return salt; }
    public void setSalt(String salt) { this.salt = salt; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public UserType getUserType() { return userType; }
    public void setUserType(UserType userType) { this.userType = userType; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    @Override
    public String toString() {
        return String.format("User{id=%d, username='%s', email='%s', type=%s}", 
            id, username, email, userType);
    }
}
