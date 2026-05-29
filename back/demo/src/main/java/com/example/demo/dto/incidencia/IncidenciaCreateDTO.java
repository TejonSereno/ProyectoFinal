package com.example.demo.dto.incidencia;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Información para crear una incidencia")
public class IncidenciaCreateDTO {

    private String titulo;
    private String descripcion;
    private String estado;
    private Long usuarioId;
    private Long comunidadId;

    public IncidenciaCreateDTO() {

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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public Long getComunidadId() {
        return comunidadId;
    }

    public void setComunidadId(Long comunidadId) {
        this.comunidadId = comunidadId;
    }
}

