package com.example.demo.controllers;

import com.example.demo.dto.votacio.VotacionCreateDTO;
import com.example.demo.dto.votacio.VotacionDTO;
import com.example.demo.dto.votacio.VotacionDetalleDTO;
import com.example.demo.services.VotacionService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/votaciones")
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
    public List<VotacionDTO> getVotacionsRecientes() {
        return votacionService.findAllRecientes();
    }
    @GetMapping("/{id}")
    public VotacionDetalleDTO getVotacion(@PathVariable Long id) {
        return votacionService.findById(id);
    }

    @PostMapping
    public VotacionDTO createVotacion(@RequestBody VotacionCreateDTO votacion) {
        return votacionService.save(votacion);
    }

    @PutMapping("/{id}")
    public VotacionDTO updateVotacion(@PathVariable Long id, @RequestBody VotacionCreateDTO votacion) {
        return votacionService.update(id, votacion);
    }

    @DeleteMapping("/{id}")
    public void deleteVotacion(@PathVariable Long id) {
        votacionService.delete(id);
    }
}
