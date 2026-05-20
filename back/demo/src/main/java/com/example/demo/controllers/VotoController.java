package com.example.demo.controllers;

import com.example.demo.dto.voto.VotoCreateDTO;
import com.example.demo.dto.voto.VotoDTO;
import com.example.demo.dto.voto.VotoDetalleDTO;
import com.example.demo.services.VotoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/votos")
public class VotoController {

    private final VotoService votoService;

    public VotoController(VotoService votoService) {
        this.votoService = votoService;
    }

    @GetMapping
    public List<VotoDTO> getVotos() {
        return votoService.findAll();
    }

    @GetMapping("/{id}")
    public VotoDetalleDTO getVoto(@PathVariable Long id){
        return votoService.findById(id);
    }
    @GetMapping("/{usuarioId}/{votacionId}")
    public VotoDTO getUserVoto(@PathVariable Long usuarioId, @PathVariable Long votacionId) {
        return votoService.findByUser(usuarioId, votacionId);
    }

    @PostMapping
    public VotoDTO createVoto(@RequestBody VotoCreateDTO voto) {
        return votoService.save(voto);
    }

    @DeleteMapping("/{id}")
    public void deleteVoto(@PathVariable Long id) {
        votoService.delete(id);
    }
}
