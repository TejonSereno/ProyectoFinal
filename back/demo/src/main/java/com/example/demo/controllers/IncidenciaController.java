package com.example.demo.controllers;

import com.example.demo.dto.incidencia.IncidenciaCreateDTO;
import com.example.demo.dto.incidencia.IncidenciaDTO;
import com.example.demo.dto.incidencia.IncidenciaDetalleDTO;
import com.example.demo.services.IncidenciaService;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/incidencias")
@Tag(name = "Incidencias", description = "Operaciones de incidencias")
public class IncidenciaController {

    private final IncidenciaService incidenciaService;
    public IncidenciaController(IncidenciaService incidenciaService) {
        this.incidenciaService = incidenciaService;
    }

    @GetMapping
    public List<IncidenciaDTO> getIncidencias() {
        return incidenciaService.findAll();
    }

    @GetMapping("/recientes")
    public List<IncidenciaDTO> getIncidenciasRecientes() {
        return incidenciaService.findAllRecientes();
    }

    @GetMapping("/{id}")
    public IncidenciaDetalleDTO getIncidencia(@PathVariable Long id) {
        return incidenciaService.findById(id);
    }

    @PostMapping
    public IncidenciaDTO createIncidencia(@RequestBody IncidenciaCreateDTO incidencia) {
        return incidenciaService.save(incidencia);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/{id}/estado")
    public void updateEstadoIncidencia(@PathVariable Long id) {
        incidenciaService.updateEstado(id);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public IncidenciaDTO updateIncidencia(@PathVariable Long id, @RequestBody IncidenciaCreateDTO incidencia) {
        return incidenciaService.update(id, incidencia);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public void deleteIncidencia(@PathVariable Long id) {
        incidenciaService.delete(id);
    }
}
