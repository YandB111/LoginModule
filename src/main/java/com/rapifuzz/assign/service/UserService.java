package com.rapifuzz.assign.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.rapifuzz.assign.entity.User;
import com.rapifuzz.assign.entity.repo.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;


    @Transactional
    public void saveUser(User user) {
        // Hash the password
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        // Save the user to the database
        userRepository.save(user);
    }



   

    // Method to find user by ID
    public Optional<User> findUserById(Long id) {
        return userRepository.findById(id);
    }
    
    public boolean authenticate(String email, String password) {
        // Fetch user by email
        User user = userRepository.findByEmail(email);
        
        if (user != null) {
            // Decrypt and compare the entered password with the stored password (BCrypt)
            return bCryptPasswordEncoder.matches(password, user.getPassword());
        }
        
        return false;
    }





    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}
