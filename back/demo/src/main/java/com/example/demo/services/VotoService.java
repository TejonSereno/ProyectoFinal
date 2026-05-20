package com.example.demo.services;

import com.example.demo.dto.voto.VotoCreateDTO;
import com.example.demo.dto.voto.VotoDTO;
import com.example.demo.dto.voto.VotoDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Voto;
import com.example.demo.repositories.UsuarioRepository;
import com.example.demo.repositories.VotacionRepository;
import com.example.demo.repositories.VotoRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VotoService {

    private final VotoRepository votoRepo;
    private final VotacionRepository votacionRepo;
    private final UsuarioRepository userRepo;

    public VotoService(VotoRepository votoRepo, VotacionRepository votacionRepo, UsuarioRepository userRepo) {
        this.votoRepo = votoRepo;
        this.votacionRepo = votacionRepo;
        this.userRepo = userRepo;
    }

    public List<VotoDTO> findAll() {
        return votoRepo.findAll()
                .stream()
                .map(VotoDTO::new)
                .toList();
    }

    public VotoDetalleDTO findById(Long id) {
        Voto voto = votoRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Voto no encontrado"));

        return new VotoDetalleDTO(voto);
    }

    public VotoDTO findByUser(Long usuarioId, Long votacionId){
        return new VotoDTO(votoRepo.findByUsuarioIdAndVotacionId(usuarioId, votacionId)
                .orElseThrow(() -> new ResourceNotFoundException("Voto no encontrado")));
    }

    public VotoDTO save(VotoCreateDTO dto) {
        Voto voto = votoRepo.findByUsuarioIdAndVotacionId(dto.getUsuarioId(), dto.getVotacionId()).orElse(new Voto());

        voto.setOpcion(dto.getOpcion());

        voto.setVotacion(
                votacionRepo.findById(dto.getVotacionId())
                        .orElseThrow(() -> new ResourceNotFoundException("Votación no encontrada"))
        );

        voto.setUsuario(
                userRepo.findById(dto.getUsuarioId())
                        .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"))
        );

        return new VotoDTO(votoRepo.save(voto));
    }

    public void delete(Long id) {
        if (!votoRepo.existsById(id)) {
            throw new ResourceNotFoundException("Voto no existe");
        }
        votoRepo.deleteById(id);
    }
}