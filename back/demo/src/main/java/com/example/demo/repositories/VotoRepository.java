package com.example.demo.repositories;

import com.example.demo.models.Voto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface VotoRepository extends JpaRepository<Voto, Long> {
    Optional<Voto> findByUsuarioIdAndVotacionId(Long usuarioId, Long VotacionId);
}
