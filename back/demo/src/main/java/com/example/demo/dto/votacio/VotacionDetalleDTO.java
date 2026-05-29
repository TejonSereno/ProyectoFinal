package com.example.demo.dto.votacio;

import com.example.demo.models.Votacion;
import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Schema(description = "Información detallada de una votacion")
public class VotacionDetalleDTO {

    @Schema(example = "1")
    private Long id;

    @Schema(example = "Instalar ascensor")
    private String titulo;

    @Schema(example = "Votacion para instalar ascensor")
    private String descripcion;

    @Schema(example = "[Si, No]")
    private List<String> opciones;

    @Schema(example = "2026-05-28T12:06:00")
    private LocalDateTime fechaInicio;

    @Schema(example = "2026-05-30T12:06:00")
    private LocalDateTime fechaFin;

    @Schema(example = "1")
    private Long comunidadId;

    @Schema(example = "{Si: 2, No: 4}")
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

