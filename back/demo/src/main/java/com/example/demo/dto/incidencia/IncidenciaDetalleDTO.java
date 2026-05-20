package com.example.demo.dto.incidencia;

import com.example.demo.models.Incidencia;

import java.time.LocalDateTime;

public class IncidenciaDetalleDTO {

    private Long id;
    private String titulo;
    private String descripcion;
    private String estado;
    private LocalDateTime fechaCreacion;
    private Long usuarioId;
    private Long comunidadId;

    public IncidenciaDetalleDTO() {
    }

    public IncidenciaDetalleDTO(Incidencia incidencia) {
        this.id = incidencia.getId();
        this.titulo = incidencia.getTitulo();
        this.descripcion = incidencia.getDescripcion();
        this.estado = incidencia.getEstado();
        this.fechaCreacion = incidencia.getFechaCreacion();
        this.usuarioId = incidencia.getUsuario().getId();
        this.comunidadId = incidencia.getComunidad().getId();
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

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
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
