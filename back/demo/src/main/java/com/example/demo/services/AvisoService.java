package com.example.demo.services;

import com.example.demo.dto.aviso.AvisoCreateDTO;
import com.example.demo.dto.aviso.AvisoDTO;
import com.example.demo.dto.aviso.AvisoDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Aviso;
import com.example.demo.repositories.AvisoRepository;
import com.example.demo.repositories.ComunidadRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AvisoService {
    final AvisoRepository avisoRepository;
    final ComunidadRepository comunidadRepository;

    public AvisoService(AvisoRepository avisoRepository, ComunidadRepository comunidadRepository){
        this.avisoRepository = avisoRepository;
        this.comunidadRepository = comunidadRepository;
    }

    public List<AvisoDTO> findAll(){
        return avisoRepository.findAll()
                .stream()
                .map(AvisoDTO::new)
                .toList();
    }

    public List<AvisoDTO> findAllActivos(){
        LocalDateTime fecha = LocalDateTime.now();
        return avisoRepository.findAllActivos(fecha);
    }

    public AvisoDetalleDTO findById(Long id){
        Aviso aviso = avisoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Aviso no encontrado"));

        return new AvisoDetalleDTO(aviso);
    }

    public AvisoDTO save(AvisoCreateDTO avisoCreateDTO){
        Aviso aviso = new Aviso();
        aviso.setTitulo(avisoCreateDTO.getTitulo());
        aviso.setDescripcion(avisoCreateDTO.getDescripcion());
        aviso.setFechaFin(avisoCreateDTO.getFechaFin());
        aviso.setComunidad(
                comunidadRepository.findById(avisoCreateDTO.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Aviso no encontrado"))
        );

        return new AvisoDTO(avisoRepository.save(aviso));
    }

    public AvisoDTO update(Long id, AvisoCreateDTO avisoCreateDTO){
        Aviso aviso = avisoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Aviso no encontrado"));
        aviso.setTitulo(avisoCreateDTO.getTitulo());
        aviso.setDescripcion(avisoCreateDTO.getDescripcion());
        aviso.setFechaFin(avisoCreateDTO.getFechaFin());
        aviso.setComunidad(
                comunidadRepository.findById(avisoCreateDTO.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );

        return new AvisoDTO(avisoRepository.save(aviso));
    }

    public void delete(Long id){
        if (!avisoRepository.existsById(id)){
            throw new ResourceNotFoundException("Votación no existe");
        }
        avisoRepository.deleteById(id);
    }

}
