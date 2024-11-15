package com.rapifuzz.assign.entity.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.rapifuzz.assign.entity.Incident;

@Repository
public interface IncidentRepository extends JpaRepository<Incident, Long> {
    List<Incident> findByUser_Id(Long userId);
    Optional<Incident> findByIncidentId(String incidentId);
}