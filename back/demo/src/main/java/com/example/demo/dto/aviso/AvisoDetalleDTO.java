package com.example.demo.dto.aviso;

import com.example.demo.models.Aviso;
import jakarta.persistence.*;

import java.time.LocalDateTime;

public class AvisoDetalleDTO {

    private Long id;
    private String titulo;

    private String descripcion;

    private LocalDateTime fechaCreacion;

    private LocalDateTime fechaFin;

    private Long comunidadId;

    public AvisoDetalleDTO(){

    }

    public AvisoDetalleDTO(Aviso aviso){
        this.id = aviso.getId();
        this.titulo = aviso.getTitulo();
        this.descripcion = aviso.getDescripcion();
        this.fechaCreacion = aviso.getFechaCreacion();
        this.fechaFin = aviso.getFechaFin();
        this.comunidadId = aviso.getComunidad().getId();
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

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public LocalDateTime getFechaFin() {
        return fechaFin;
    }
    public void setFechaFin(LocalDateTime fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Long getComunidadId() {
        return id;
    }
    public void setComunidadId(Long id) {
        this.comunidadId = id;
    }
}
