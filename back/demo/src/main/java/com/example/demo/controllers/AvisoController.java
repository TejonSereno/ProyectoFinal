package com.example.demo.controllers;


import com.example.demo.dto.aviso.AvisoCreateDTO;
import com.example.demo.dto.aviso.AvisoDetalleDTO;
import com.example.demo.dto.aviso.AvisoDTO;
import com.example.demo.services.AvisoService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/avisos")
public class AvisoController {

    private final AvisoService avisoService;

    public AvisoController(AvisoService avisoService) {
        this.avisoService = avisoService;
    }

    @GetMapping
    public List<AvisoDTO> getAvisos() {
        return avisoService.findAll();
    }

    @GetMapping("/activos")
    public List<AvisoDTO> getAvisosActivos() {
        return avisoService.findAllActivos();
    }

    @GetMapping("/{id}")
    public AvisoDetalleDTO getAviso(@PathVariable Long id) {
        return avisoService.findById(id);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public AvisoDTO createAviso(@RequestBody AvisoCreateDTO aviso) {
        return avisoService.save(aviso);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public AvisoDTO updateAviso(@PathVariable Long id, @RequestBody AvisoCreateDTO aviso) {
        return avisoService.update(id, aviso);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public void deleteAviso(@PathVariable Long id) {
        avisoService.delete(id);
    }
}

