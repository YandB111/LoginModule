package com.rapifuzz.assign.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.rapifuzz.assign.entity.Incident;
import com.rapifuzz.assign.entity.User;
import com.rapifuzz.assign.service.IncidentService;
import com.rapifuzz.assign.service.UserService;

import jakarta.servlet.http.HttpSession;
@RestController
@RequestMapping("/api")
public class IncidentController {
    
    @Autowired
    private IncidentService incidentService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/incident")
    public String showIncidentPage() {
        return "incident"; // The JSP file is /WEB-INF/views/user-registration.jsp
    }

    
    
    // Endpoint to create an incident
    @PostMapping("/create")
    public ResponseEntity<String> createIncident(HttpSession session, 
                                                 @RequestParam String incidentId, 
                                                 @RequestParam String details, 
                                                 @RequestParam String priority,
                                                 @RequestParam String status,
                                                 @RequestParam String nameReport) {

        // Retrieve userId from the session (assuming it was stored during login)
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            System.out.println("User ID not found in session.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        // Retrieve the User object from the database based on the userId
        Optional<User> userOptional = userService.findUserById(userId);

        if (!userOptional.isPresent()) {
            System.out.println("User not found for ID: " + userId);
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
        }

        User user = userOptional.get();

        // Create and populate the incident object
        Incident incident = new Incident();
        incident.setIncidentId(incidentId);
        incident.setDetails(details);
        incident.setPriority(priority);
        incident.setStatus(status);
        incident.setUser(user);
        incident.setReporterName(nameReport);
        incident.setReportedDateTime(LocalDateTime.now());

        // Log the incident details before saving to database
        System.out.println("Incident details before saving: " + incident);

        // Save the incident
        Incident createdIncident = incidentService.createIncident(incident);

        // Log after saving
        System.out.println("Incident saved: " + createdIncident);

        return ResponseEntity.ok("Incident saved successfully!");
    }


    // Endpoint to get incidents for a specific user
    @GetMapping("/user/{userId}")
    public List<Incident> getUserIncidents(@PathVariable Long userId) {
        return incidentService.findUserIncidents(userId);
    }

    // Endpoint to edit incident
    @PutMapping("/edit/{incidentId}")
    public ResponseEntity<Incident> editIncident(@PathVariable String incidentId, @RequestBody Incident incident) {
        // Only allow editing if status is not "Closed"
        if (incident.getStatus().equalsIgnoreCase("Closed")) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
        }
        return ResponseEntity.ok(incidentService.updateIncident(incidentId, incident));
    }
}