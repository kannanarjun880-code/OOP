package com.quizapp;

import com.quizapp.ui.LoginFrame;
import com.quizapp.util.DatabaseConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.swing.*;

/**
 * Main application class for Online Quiz System
 */
public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);
    
    public static void main(String[] args) {
        // Set system look and feel
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeel());
        } catch (Exception e) {
            logger.warn("Could not set system look and feel", e);
        }
        
        // Test database connection
        if (!DatabaseConnection.testConnection()) {
            JOptionPane.showMessageDialog(null,
                "Cannot connect to database. Please ensure:\n" +
                "1. MySQL server is running\n" +
                "2. Database 'quiz_system' exists\n" +
                "3. User 'quiz_user' with password 'quiz_password' has access",
                "Database Connection Error", JOptionPane.ERROR_MESSAGE);
            System.exit(1);
        }
        
        logger.info("Online Quiz System starting...");
        
        // Start the application on EDT
        SwingUtilities.invokeLater(() -> {
            LoginFrame loginFrame = new LoginFrame();
            loginFrame.setVisible(true);
            logger.info("Application started successfully");
        });
    }
}
