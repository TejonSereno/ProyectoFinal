package com.example.demo.controllers;


import com.example.demo.dto.aviso.AvisoCreateDTO;
import com.example.demo.dto.aviso.AvisoDetalleDTO;
import com.example.demo.dto.aviso.AvisoDTO;
import com.example.demo.services.AvisoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/avisos")
public class AvisoController {

    private final AvisoService avisoService;

    public AvisoController(AvisoService avisoService) {
        this.avisoService = avisoService;
    }

    @GetMapping
    public List<AvisoDTO> getVotacions() {
        return avisoService.findAll();
    }

    @GetMapping("/activos")
    public List<AvisoDTO> getVotacionsActivos() {
        return avisoService.findAllActivos();
    }
    @GetMapping("/{id}")
    public AvisoDetalleDTO getVotacion(@PathVariable Long id) {
        return avisoService.findById(id);
    }

    @PostMapping
    public AvisoDTO createVotacion(@RequestBody AvisoCreateDTO aviso) {
        return avisoService.save(aviso);
    }

    @PutMapping("/{id}")
    public AvisoDTO updateVotacion(@PathVariable Long id, @RequestBody AvisoCreateDTO aviso) {
        return avisoService.update(id, aviso);
    }

    @DeleteMapping("/{id}")
    public void deleteVotacion(@PathVariable Long id) {
        avisoService.delete(id);
    }
}

