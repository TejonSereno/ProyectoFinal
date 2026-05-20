package com.example.demo.services;

import com.example.demo.dto.votacio.VotacionCreateDTO;
import com.example.demo.dto.votacio.VotacionDTO;
import com.example.demo.dto.votacio.VotacionDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.repositories.ComunidadRepository;
import com.example.demo.repositories.VotacionRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class VotacionService {

    private final VotacionRepository votacionRepo;
    private final ComunidadRepository comunidadRepo;
    public VotacionService(VotacionRepository votacionRepository, ComunidadRepository comunidadRepository) {
        this.votacionRepo = votacionRepository;
        this.comunidadRepo = comunidadRepository;
    }

    public List<VotacionDTO> findAll(){
        return votacionRepo.findAll()
                .stream()
                .map(VotacionDTO::new)
                .toList();
    }

    public List<VotacionDTO> findAllRecientes() {
        LocalDateTime fecha = LocalDateTime.now().minusWeeks(1);
        return votacionRepo.findAllRecientes(fecha, LocalDateTime.now());
    }

    public VotacionDetalleDTO findById(Long id){
        com.example.demo.models.Votacion votacion = votacionRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Votación no encontrada"));

        return new VotacionDetalleDTO(votacion);
    }

    public VotacionDTO save(VotacionCreateDTO dto){
        com.example.demo.models.Votacion votacion = new com.example.demo.models.Votacion();
        votacion.setTitulo(dto.getTitulo());
        votacion.setDescripcion(dto.getDescripcion());
        votacion.setOpciones(dto.getOpciones());
        votacion.setFechaFin(dto.getFechaFin());
        votacion.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );
        return new VotacionDTO(votacionRepo.save(votacion));
    }

    public VotacionDTO update(Long id, VotacionCreateDTO dto) {
        com.example.demo.models.Votacion votacion = votacionRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Votación no encontrada"));

        votacion.setTitulo(dto.getTitulo());
        votacion.setDescripcion(dto.getDescripcion());
        votacion.setOpciones(dto.getOpciones());
        votacion.setFechaFin(dto.getFechaFin());
        votacion.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );

        return new VotacionDTO(votacionRepo.save(votacion));
    }

    public void delete(Long id){
        if (!votacionRepo.existsById(id)) {
            throw new ResourceNotFoundException("Votación no existe");
        }
        votacionRepo.deleteById(id);
    }
}
