package com.example.demo.services;

import com.example.demo.dto.comunidad.ComunidadCreateDTO;
import com.example.demo.dto.comunidad.ComunidadDTO;
import com.example.demo.dto.comunidad.ComunidadDetalleDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Comunidad;
import com.example.demo.repositories.ComunidadRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComunidadService {
    private final ComunidadRepository comunidadRepository;
    public ComunidadService(ComunidadRepository comunidadRepository) {
        this.comunidadRepository = comunidadRepository;
    }

    public List<ComunidadDTO> findAll(){
        return comunidadRepository.findAll()
                .stream()
                .map(ComunidadDTO::new)
                .toList();
    }

    public ComunidadDetalleDTO findById(Long id){
        Comunidad comunidad = comunidadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"));
        return new ComunidadDetalleDTO(comunidad);
    }

    public ComunidadDTO save(ComunidadCreateDTO dto){
        Comunidad comunidad = new Comunidad();
        comunidad.setNombre(dto.getNombre());
        comunidad.setDireccion(dto.getDireccion());
        return new ComunidadDTO(comunidadRepository.save(comunidad));
    }

    public ComunidadDTO update(Long id, ComunidadCreateDTO dto) {
        Comunidad comunidad = comunidadRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"));
        comunidad.setNombre(dto.getNombre());
        comunidad.setDireccion(dto.getDireccion());
        return new ComunidadDTO(comunidadRepository.save(comunidad));
    }

    public void delete(Long id){
        if (!comunidadRepository.existsById(id)) {
            throw new ResourceNotFoundException("Comunidad no existe");
        }
        comunidadRepository.deleteById(id);
    }
}
