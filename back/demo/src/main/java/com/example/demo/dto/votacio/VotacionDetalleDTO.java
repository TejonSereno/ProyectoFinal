package com.example.demo.dto.votacio;

import com.example.demo.models.Votacion;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class VotacionDetalleDTO {

    private Long id;
    private String titulo;
    private String descripcion;
    private List<String> opciones;
    private LocalDateTime fechaInicio;
    private LocalDateTime fechaFin;

    private Long comunidadId;

    private Map<String, Long> resultados;

    public VotacionDetalleDTO() {
    }

    public VotacionDetalleDTO(Votacion votacion) {
        this.id = votacion.getId();
        this.titulo = votacion.getTitulo();
        this.descripcion = votacion.getDescripcion();
        this.opciones = votacion.getOpciones();
        this.fechaInicio = votacion.getFechaInicio();
        this.fechaFin = votacion.getFechaFin();
        this.comunidadId = votacion.getComunidad().getId();

        this.resultados = new HashMap<>();
        if (votacion.getOpciones() != null) {
            for (String opcion : votacion.getOpciones()) {
                this.resultados.put(opcion, 0L);
            }
        }
        if (votacion.getVotos() != null) {
            votacion.getVotos().forEach(voto ->
                    this.resultados.merge(voto.getOpcion(), 1L, Long::sum)
            );
        }
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

    public List<String> getOpciones() {
        return opciones;
    }

    public void setOpciones(List<String> opciones) {
        this.opciones = opciones;
    }

    public LocalDateTime getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDateTime fechaInicio) {
        this.fechaInicio = fechaInicio;
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

    public Map<String, Long> getResultados() {
        return resultados;
    }

    public void setResultados(Map<String, Long> resultados) {
        this.resultados = resultados;
    }
}

