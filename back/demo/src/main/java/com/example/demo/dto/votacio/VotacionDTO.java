package com.example.demo.dto.votacio;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

@Schema(description = "Información de una votacion")
public class VotacionDTO {

    private Long id;
    private String titulo;
    private String descripcion;
    private LocalDateTime fechaFin;
    private Long totalVotos;

    public VotacionDTO() {
    }

    public VotacionDTO(Long id, String titulo, String descripcion, LocalDateTime fechaFin, Long totalVotos) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaFin = fechaFin;
        this.totalVotos = totalVotos;
    }
    public VotacionDTO(com.example.demo.models.Votacion votacion) {
        this.id = votacion.getId();
        this.titulo = votacion.getTitulo();
        this.descripcion = votacion.getDescripcion();
        this.fechaFin = votacion.getFechaFin();
        this.totalVotos = votacion.getVotos() != null
                ? Long.valueOf(votacion.getVotos().size()) : 0L;
    }

    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public LocalDateTime getFechaFin() {
        return fechaFin;
    }
    public void setFechaFin(LocalDateTime fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Long getTotalVotos() {
        return totalVotos;
    }
    public void setTotalVotos(Long totalVotos) {
        this.totalVotos = totalVotos;
    }
}
