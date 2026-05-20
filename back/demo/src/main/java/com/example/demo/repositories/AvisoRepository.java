package com.example.demo.repositories;

import com.example.demo.dto.aviso.AvisoDTO;
import com.example.demo.models.Aviso;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AvisoRepository extends JpaRepository<Aviso, Long> {
    @Query("""
        SELECT new com.example.demo.dto.aviso.AvisoDTO(
        a.id, a.titulo, a.descripcion, a.fechaFin)
        FROM Aviso a
        WHERE a.fechaFin >= :fecha
        ORDER BY a.fechaFin DESC
    """)
    List<AvisoDTO> findAllActivos(@Param("fecha") LocalDateTime fecha);

}
