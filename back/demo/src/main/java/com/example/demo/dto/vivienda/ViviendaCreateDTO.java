package com.example.demo.dto.vivienda;

public class ViviendaCreateDTO {

    private String calle;
    private String numero;
    private Long comunidadId;

    public ViviendaCreateDTO() {
    }

    public String getCalle() {
        return calle;
    }
    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getNumero() {
        return numero;
    }
    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Long getComunidadId() {
        return comunidadId;
    }
    public void setComunidadId(Long comunidadId) {
        this.comunidadId = comunidadId;
    }
}