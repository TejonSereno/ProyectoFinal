package com.example.demo.repositories;

import com.example.demo.dto.incidencia.IncidenciaDTO;
import com.example.demo.models.Incidencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface IncidenciaRepository extends JpaRepository<Incidencia, Long> {
    @Query("""
        SELECT new com.example.demo.dto.incidencia.IncidenciaDTO(
        i.id, i.titulo, i.descripcion, i.estado)
        FROM Incidencia i
        WHERE i.fechaFin >= :fecha OR i.fechaFin IS NULL
        ORDER BY i.id, i.estado
    """)
    List<IncidenciaDTO> findAllRecientes(@Param("fecha") LocalDateTime fecha);
}
