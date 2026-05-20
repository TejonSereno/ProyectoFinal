package com.example.demo.dto.aviso;

import com.example.demo.models.Aviso;

import java.time.LocalDateTime;

public class AvisoDTO {
    private Long id;
    private String titulo;
    private String descripcion;
    private LocalDateTime fechaFin;

    public AvisoDTO(){

    }

    public AvisoDTO(Long id, String titulo, String descripcion, LocalDateTime fechaFin){
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fechaFin = fechaFin;
    }

    public AvisoDTO(Aviso aviso){
        this.id = aviso.getId();
        this.titulo = aviso.getTitulo();
        this.descripcion = aviso.getDescripcion();
        this.fechaFin = aviso.getFechaFin();
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
}
