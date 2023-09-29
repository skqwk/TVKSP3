package com.example.practice3.student;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

/**
 * Данные по студенту
 */
@Entity
@Getter
@Setter
public class Student {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    /**
     * Имя студента
     */
    private String name;

    /**
     * Фамилия студента
     */
    private String surname;

    /**
     * Отчество студента
     */
    private String patronymic;

    /**
     * Группа студента
     */
    private String groupName;

    /**
     * Возраст
     */
    private int age;
}
