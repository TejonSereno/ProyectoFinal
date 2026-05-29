package com.example.demo.dto.aviso;

import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;

@Schema(description = "Información para crear un aviso")
public class AvisoCreateDTO {
    private String titulo;
    private String descripcion;
    private LocalDateTime fechaFin;
    private Long comunidadId;

    public AvisoCreateDTO(){

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

    public Long getComunidadId() {
        return comunidadId;
    }
    public void setComunidadId(Long comunidadId) {
        this.comunidadId = comunidadId;
    }
}
