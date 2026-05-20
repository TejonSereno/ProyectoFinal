package com.example.demo.services;

import com.example.demo.dto.incidencia.IncidenciaCreateDTO;
import com.example.demo.dto.incidencia.IncidenciaDTO;
import com.example.demo.dto.incidencia.IncidenciaDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Incidencia;
import com.example.demo.repositories.ComunidadRepository;
import com.example.demo.repositories.IncidenciaRepository;
import com.example.demo.repositories.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class IncidenciaService {

    private final IncidenciaRepository incidenciaRepo;
    private final UsuarioRepository usuarioRepo;
    private final ComunidadRepository comunidadRepo;
    public IncidenciaService(IncidenciaRepository incidenciaRepo, UsuarioRepository usuarioRepo, ComunidadRepository comunidadRepo) {
        this.incidenciaRepo = incidenciaRepo;
        this.usuarioRepo = usuarioRepo;
        this.comunidadRepo = comunidadRepo;
    }

    public List<IncidenciaDTO> findAll(){
        return incidenciaRepo.findAll()
            .stream()
            .map(IncidenciaDTO::new)
            .toList();
    }

    public List<IncidenciaDTO> findAllRecientes(){
        LocalDateTime fecha = LocalDateTime.now().minusWeeks(1);
        return incidenciaRepo.findAllRecientes(fecha);
    }

    public IncidenciaDetalleDTO findById(Long id){
        Incidencia incidencia = incidenciaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Incidencia no encontrada"));
        return new IncidenciaDetalleDTO(incidencia);
    }

    public IncidenciaDTO save(IncidenciaCreateDTO dto){
        Incidencia incidencia = new Incidencia();
        incidencia.setTitulo(dto.getTitulo());
        incidencia.setDescripcion(dto.getDescripcion());
        incidencia.setEstado(dto.getEstado());
        incidencia.setUsuario(
                usuarioRepo.findById(dto.getUsuarioId())
                        .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"))
        );
        incidencia.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );
        return new IncidenciaDTO(incidenciaRepo.save(incidencia));
    }

    public IncidenciaDTO update(Long id, IncidenciaCreateDTO dto) {
        Incidencia incidencia = incidenciaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Incidencia no encontrada"));

        incidencia.setTitulo(dto.getTitulo());
        incidencia.setDescripcion(dto.getDescripcion());
        incidencia.setEstado(dto.getEstado());
        incidencia.setUsuario(
                usuarioRepo.findById(dto.getUsuarioId())
                        .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"))
        );
        incidencia.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );

        return new IncidenciaDTO(incidenciaRepo.save(incidencia));
    }

    public void updateEstado(Long id) {
        Incidencia i = incidenciaRepo.findById(id).orElseThrow(() -> new ResourceNotFoundException("Incidencia no encontrada"));

        switch (i.getEstado()) {
            case "PENDIENTE" -> i.setEstado("EN PROCESO");
            case "EN PROCESO" -> i.setEstado("FINALIZADA");
            default -> i.setEstado("PENDIENTE");
        }

        incidenciaRepo.save(i);
    }

    public void delete(Long id){
        if (!incidenciaRepo.existsById(id)) {
            throw new ResourceNotFoundException("Incidencia no existe");
        }
        incidenciaRepo.deleteById(id);
    }
}
