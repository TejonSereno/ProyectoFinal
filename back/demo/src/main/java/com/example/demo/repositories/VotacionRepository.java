package com.example.demo.repositories;

import com.example.demo.dto.votacio.VotacionDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface VotacionRepository extends JpaRepository<com.example.demo.models.Votacion, Long> {
    @Query("""
    SELECT new com.example.demo.dto.votacio.VotacionDTO(
        v.id, v.titulo, v.descripcion, v.fechaFin, COUNT(vv.id)
    )
    FROM Votacion v
    LEFT JOIN v.votos vv
    WHERE v.fechaFin >= :fechaLimite OR v.fechaFin IS NULL
    GROUP BY v.id, v.titulo, v.descripcion, v.fechaFin
    ORDER BY
        CASE
            WHEN v.fechaFin >= :ahora THEN 0
            ELSE 1
        END ASC,

        CASE
            WHEN v.fechaFin >= :ahora THEN v.fechaFin
        END ASC,

        CASE
            WHEN v.fechaFin < :ahora THEN v.fechaFin
        END DESC
""")
    List<VotacionDTO> findAllRecientes(
            @Param("fechaLimite") LocalDateTime fechaLimite,
            @Param("ahora") LocalDateTime ahora
    );
}
