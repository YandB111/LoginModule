package com.rapifuzz.assign.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;  // Correct import
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.rapifuzz.assign.entity.User;
import com.rapifuzz.assign.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/users/api")
public class UserController {

    @Autowired
    private UserService userService;

    // Display the registration page (JSP)
    @GetMapping("/register")
    public String showRegistrationPage() {
        return "user-registration"; // The JSP file is /WEB-INF/views/user-registration.jsp
    }

    // Register user and save to database
    @PostMapping("/save")
    public ModelAndView saveUser(@Valid @ModelAttribute User user, BindingResult bindingResult) {
        // Handle validation errors
        if (bindingResult.hasErrors()) {
            return new ModelAndView("user-registration"); // Show the registration page again on error
        }

        // Save user logic here (password is directly saved, no confirm password logic)
        userService.saveUser(user);

        // Redirect to login page after successful registration
        return new ModelAndView("redirect:/login"); // This will redirect to /login.jsp
    }

    // Get a user by ID
    @GetMapping("/{id}")
    public ResponseEntity<User> getUser(@PathVariable Long id) {
        return userService.findUserById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    // Login handling
    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        // Authenticate the user
        boolean isAuthenticated = userService.authenticate(email, password);

        // Return appropriate response
        if (isAuthenticated) {
            // Fetch the user from the database using email
            User user = userService.findByEmail(email);
            
            // Store the userId in the session
            session.setAttribute("userId", user.getId());  // Store the userId in the session

            model.addAttribute("userEmail", email);  // Optionally add the email for display
            return "incident";  // This will resolve to incident.jsp
        } else {
            model.addAttribute("error", "Invalid email or password.");
            return "login";  // This will resolve to login.jsp
        }
    }

    // Show login page
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";  // This will forward to /WEB-INF/views/login.jsp
    }
}
