package com.rapifuzz.assign.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rapifuzz.assign.entity.Incident;
import com.rapifuzz.assign.entity.repo.IncidentRepository;
import com.rapifuzz.assign.exception.ResourceNotFoundException;
@Service
public class IncidentService {
    
    @Autowired
    private IncidentRepository incidentRepository;
    
    // Method to create a new incident
    public Incident createIncident(Incident incident) {
        // Debugging output to check the input incident
        System.out.println("Creating incident: " + incident);
        
        // Set the incident ID and reported date
        incident.setIncidentId(generateUniqueIncidentId());
        incident.setReportedDateTime(LocalDateTime.now());

        // Save the incident to the repository
        Incident savedIncident = incidentRepository.save(incident);

        // Debugging output to check the saved incident
        System.out.println("Incident saved: " + savedIncident);

        return savedIncident;
    }


    // Method to find incidents for a user
    public List<Incident> findUserIncidents(Long userId) {
        return incidentRepository.findByUser_Id(userId);
    }

    // Method to generate unique Incident ID
    private String generateUniqueIncidentId() {
        String incidentId;
        do {
            incidentId = "RMG" + new Random().nextInt(100000) + LocalDate.now().getYear();
        } while (incidentRepository.findByIncidentId(incidentId).isPresent());
        return incidentId;
    }

    // Method to update an incident (if it's not closed)
    public Incident updateIncident(String incidentId, Incident updatedIncident) {
        Incident incident = incidentRepository.findByIncidentId(incidentId)
            .orElseThrow(() -> new ResourceNotFoundException("Incident not found"));

        // Update the incident fields
        incident.setDetails(updatedIncident.getDetails());
        incident.setPriority(updatedIncident.getPriority());
        incident.setStatus(updatedIncident.getStatus());
        return incidentRepository.save(incident);
    }

	public List<Incident> getAllIncidents() {
		// TODO Auto-generated method stub
		throw new UnsupportedOperationException("Unimplemented method 'getAllIncidents'");
	}
}
