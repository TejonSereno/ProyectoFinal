package com.example.demo.controllers;

import com.example.demo.dto.vivienda.ViviendaCreateDTO;
import com.example.demo.dto.vivienda.ViviendaDTO;
import com.example.demo.dto.vivienda.ViviendaDetalleDTO;
import com.example.demo.dto.vivienda.ViviendaListadoDTO;
import com.example.demo.services.ViviendaService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/viviendas")
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

    @PostMapping
    public ViviendaDTO createVivienda(@RequestBody ViviendaCreateDTO vivienda) {
        return viviendaService.save(vivienda);
    }

    @PutMapping("/{id}")
    public ViviendaDTO updateVivienda(@PathVariable Long id, @RequestBody ViviendaCreateDTO vivienda) {
        return viviendaService.update(id, vivienda);
    }

    @DeleteMapping("/{id}")
    public void deleteVivienda(@PathVariable Long id) {
        viviendaService.delete(id);
    }
}