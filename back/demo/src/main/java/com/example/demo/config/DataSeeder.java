package com.example.demo.config;

import com.example.demo.models.*;
import com.example.demo.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Configuration
public class DataSeeder {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    CommandLineRunner initData(
            ComunidadRepository comunidadRepo,
            UsuarioRepository usuarioRepo,
            ViviendaRepository viviendaRepo,
            VotacionRepository votacionRepo,
            VotoRepository votoRepo,
            IncidenciaRepository incidenciaRepo,
            AvisoRepository avisoRepo
    ) {
        return args -> {
            if (comunidadRepo.count() > 0) return;

            // =====================
            // COMUNIDAD
            // =====================
            Comunidad comunidad = new Comunidad();
            comunidad.setNombre("Comunidad Edificio Central");
            comunidad.setDireccion("Calle Mayor 123");
            comunidadRepo.save(comunidad);

            // =====================
            // VIVIENDAS
            // =====================
            Vivienda v1 = new Vivienda();
            v1.setCalle("Calle Mayor");
            v1.setNumero("1A");
            v1.setComunidad(comunidad);

            Vivienda v2 = new Vivienda();
            v2.setCalle("Calle Mayor");
            v2.setNumero("2B");
            v2.setComunidad(comunidad);

            viviendaRepo.saveAll(List.of(v1, v2));

            // =====================
            // USUARIOS
            // =====================
            Usuario admin = new Usuario();
            admin.setNombre("Admin");
            admin.setEmail("admin@test.com");
            admin.setPassword(passwordEncoder.encode("1234"));
            admin.setRol("ADMIN");
            admin.setComunidad(comunidad);

            Usuario user1 = new Usuario();
            user1.setNombre("Juan Pérez");
            user1.setEmail("juan@test.com");
            user1.setPassword(passwordEncoder.encode("1234"));
            user1.setRol("USER");
            user1.setComunidad(comunidad);
            user1.setVivienda(v1);

            Usuario user2 = new Usuario();
            user2.setNombre("María López");
            user2.setEmail("maria@test.com");
            user2.setPassword(passwordEncoder.encode("1234"));
            user2.setRol("USER");
            user2.setComunidad(comunidad);
            user2.setVivienda(v2);

            Usuario user3 = new Usuario();
            user3.setNombre("Jaime Rodrigez");
            user3.setEmail("jaime@test.com");
            user3.setPassword(passwordEncoder.encode("1234"));
            user3.setRol("USER");
            user3.setComunidad(comunidad);

            usuarioRepo.saveAll(List.of(admin, user1, user2, user3));

            // =====================
            // VOTACION
            // =====================
            Votacion votacion = new Votacion();
            votacion.setTitulo("Instalar ascensor");
            votacion.setDescripcion("Votación para instalar ascensor");
            votacion.setOpciones(Arrays.asList("SI", "NO"));
            votacion.setFechaFin(LocalDateTime.now().plusDays(7));
            votacion.setComunidad(comunidad);

            votacionRepo.save(votacion);

            // =====================
            // VOTOS
            // =====================
            Voto voto1 = new Voto();
            voto1.setOpcion("SI");
            voto1.setUsuario(user1);
            voto1.setVotacion(votacion);

            Voto voto2 = new Voto();
            voto2.setOpcion("NO");
            voto2.setUsuario(user2);
            voto2.setVotacion(votacion);

            votoRepo.saveAll(List.of(voto1, voto2));

            // =====================
            // INCIDENCIAS
            // =====================
            Incidencia incidencia = new Incidencia();
            incidencia.setTitulo("Luz rota");
            incidencia.setDescripcion("La luz del portal no funciona");
            incidencia.setEstado("PENDIENTE");
            incidencia.setUsuario(user1);
            incidencia.setComunidad(comunidad);

            incidenciaRepo.save(incidencia);

            // =====================
            // AVISOS
            // =====================
            Aviso aviso = new Aviso();
            aviso.setTitulo("Mantenimiento Piscina");
            aviso.setDescripcion("La piscina estara cerrada al publico el dia 25/05/2026 por labores de mantenimiento");
            aviso.setFechaFin(LocalDateTime.now().plusDays(15));
            aviso.setComunidad(comunidad);

            avisoRepo.save(aviso);

            System.out.println("Datos iniciales cargados correctamente");
        };
    }
}