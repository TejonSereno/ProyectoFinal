package com.example.demo.controllers;

import com.example.demo.dto.comunidad.ComunidadCreateDTO;
import com.example.demo.dto.comunidad.ComunidadDTO;
import com.example.demo.dto.comunidad.ComunidadDetalleDTO;
import com.example.demo.services.ComunidadService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/comunidades")
public class ComunidadController {

    private final ComunidadService comunidadService;

    public ComunidadController(ComunidadService comunidadService) {
        this.comunidadService = comunidadService;
    }

    @GetMapping
    public List<ComunidadDTO> getComunidades() {
        return comunidadService.findAll();
    }

    @GetMapping("/{id}")
    public ComunidadDetalleDTO getComunidad(@PathVariable Long id) {
        return comunidadService.findById(id);
    }

    @PostMapping
    public ComunidadDTO createComunidad(@RequestBody ComunidadCreateDTO comunidad) {
        return comunidadService.save(comunidad);
    }

    @PutMapping("/{id}")
    public ComunidadDTO updateComunidad(@PathVariable Long id, @RequestBody ComunidadCreateDTO comunidad) {
        return comunidadService.update(id, comunidad);
    }

    @DeleteMapping("/{id}")
    public void deleteComunidad(@PathVariable Long id) {
        comunidadService.delete(id);
    }
}
