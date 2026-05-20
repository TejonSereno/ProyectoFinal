package com.example.demo.services;

import com.example.demo.dto.vivienda.ViviendaCreateDTO;
import com.example.demo.dto.vivienda.ViviendaDTO;
import com.example.demo.dto.vivienda.ViviendaDetalleDTO;
import com.example.demo.dto.vivienda.ViviendaListadoDTO;
import com.example.demo.exceptions.ResourceNotFoundException;
import com.example.demo.models.Vivienda;
import com.example.demo.repositories.ComunidadRepository;
import com.example.demo.repositories.ViviendaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ViviendaService {

    private final ViviendaRepository viviendaRepo;
    private final ComunidadRepository comunidadRepo;
    public ViviendaService(ViviendaRepository viviendaRepository, ComunidadRepository comunidadRepository) {
        this.viviendaRepo = viviendaRepository;
        this.comunidadRepo = comunidadRepository;
    }

    public List<ViviendaDTO> findAll(){
        return viviendaRepo.findAll()
                .stream()
                .map(ViviendaDTO::new)
                .toList();
    }

    public List<ViviendaListadoDTO> findAllListado() {
        return viviendaRepo.findAllListado();
    }

    public ViviendaDetalleDTO findById(Long id){
        Vivienda vivienda = viviendaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vivienda no encontrada"));
        return new ViviendaDetalleDTO(vivienda);
    }

    public ViviendaDTO save(ViviendaCreateDTO dto){
        Vivienda vivienda = new Vivienda();
        vivienda.setCalle(dto.getCalle());
        vivienda.setNumero(dto.getNumero());
        vivienda.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );
        return new ViviendaDTO(viviendaRepo.save(vivienda));
    }

    public ViviendaDTO update(Long id, ViviendaCreateDTO dto) {
        Vivienda vivienda = viviendaRepo.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vivienda no encontrada"));

        vivienda.setCalle(dto.getCalle());
        vivienda.setNumero(dto.getNumero());
        vivienda.setComunidad(
                comunidadRepo.findById(dto.getComunidadId())
                        .orElseThrow(() -> new ResourceNotFoundException("Comunidad no encontrada"))
        );

        return new ViviendaDTO(viviendaRepo.save(vivienda));
    }

    public void delete(Long id){
        if (!viviendaRepo.existsById(id)) {
            throw new ResourceNotFoundException("Vivienda no existe");
        }
        viviendaRepo.deleteById(id);
    }
}
