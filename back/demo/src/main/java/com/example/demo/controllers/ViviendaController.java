package com.example.demo.controllers;

import com.example.demo.dto.vivienda.ViviendaCreateDTO;
import com.example.demo.dto.vivienda.ViviendaDTO;
import com.example.demo.dto.vivienda.ViviendaDetalleDTO;
import com.example.demo.dto.vivienda.ViviendaListadoDTO;
import com.example.demo.services.ViviendaService;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/viviendas")
@Tag(name = "Viviendas", description = "Operaciones de Viviendas")
public class ViviendaController {

    private final ViviendaService viviendaService;

    public ViviendaController(ViviendaService viviendaService) {
        this.viviendaService = viviendaService;
    }

    @GetMapping
    public List<ViviendaDTO> getViviendas() {
        return viviendaService.findAll();
    }

    @GetMapping("/listado")
    public List<ViviendaListadoDTO> getViviendasListado() {
        return viviendaService.findAllListado();
    }

    @GetMapping("/{id}")
    public ViviendaDetalleDTO getVivienda(@PathVariable Long id) {
        return viviendaService.findById(id);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public ViviendaDTO createVivienda(@RequestBody ViviendaCreateDTO vivienda) {
        return viviendaService.save(vivienda);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public ViviendaDTO updateVivienda(@PathVariable Long id, @RequestBody ViviendaCreateDTO vivienda) {
        return viviendaService.update(id, vivienda);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public void deleteVivienda(@PathVariable Long id) {
        viviendaService.delete(id);
    }
}