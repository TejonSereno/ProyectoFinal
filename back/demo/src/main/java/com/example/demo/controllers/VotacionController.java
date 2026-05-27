package com.example.demo.controllers;

import com.example.demo.dto.votacio.VotacionCreateDTO;
import com.example.demo.dto.votacio.VotacionDTO;
import com.example.demo.dto.votacio.VotacionDetalleDTO;
import com.example.demo.services.VotacionService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/votaciones")
public class VotacionController {

    private final VotacionService votacionService;

    public VotacionController(VotacionService votacionService) {
        this.votacionService = votacionService;
    }

    @GetMapping
    public List<VotacionDTO> getVotacions() {
        return votacionService.findAll();
    }

    @GetMapping("/recientes")
    public List<VotacionDTO> getVotacionesRecientes() {
        return votacionService.findAllRecientes();
    }

    @GetMapping("/{id}")
    public VotacionDetalleDTO getVotacion(@PathVariable Long id) {
        return votacionService.findById(id);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public VotacionDTO createVotacion(@RequestBody VotacionCreateDTO votacion) {
        return votacionService.save(votacion);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PutMapping("/{id}")
    public VotacionDTO updateVotacion(@PathVariable Long id, @RequestBody VotacionCreateDTO votacion) {
        return votacionService.update(id, votacion);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @DeleteMapping("/{id}")
    public void deleteVotacion(@PathVariable Long id) {
        votacionService.delete(id);
    }
}
