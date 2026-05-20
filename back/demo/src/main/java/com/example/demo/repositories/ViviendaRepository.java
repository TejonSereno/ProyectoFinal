package com.example.demo.repositories;

import com.example.demo.dto.vivienda.ViviendaListadoDTO;
import com.example.demo.models.Vivienda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViviendaRepository extends JpaRepository<Vivienda, Long> {
    @Query("""
            SELECT new com.example.demo.dto.vivienda.ViviendaListadoDTO(
            v.id, v.calle, v.numero, COUNT(u)
        )
        FROM Vivienda v
        LEFT JOIN v.usuarios u
        GROUP BY v.id, v.calle, v.numero
    """)
    List<ViviendaListadoDTO> findAllListado();
}
