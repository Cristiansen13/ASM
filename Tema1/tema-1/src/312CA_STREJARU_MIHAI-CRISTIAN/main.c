#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"

void salt1(FILE *in) {
	float date; int date1;
	fread(&date, 1, sizeof(float), in);
	fread(&date, 1, sizeof(float), in);
	fread(&date, 1, sizeof(float), in);
	fread(&date1, 1, sizeof(int), in);
	fread(&date1, 1, sizeof(int), in);
	int nrop; int op;
	fread(&nrop, 1, sizeof(int), in);
	for (int i = 0; i < nrop; i++) {
		fread(&op, 1, sizeof(int), in);
	}
}

void salt2(FILE *in) {
	float date; int date1;
	fread(&date, 1, sizeof(float), in); 
	fread(&date, 1, sizeof(float), in); 
	fread(&date1, 1, sizeof(int), in); 
	fread(&date1, 1, sizeof(int), in);
	int nrop; int op;
	fread(&nrop, 1, sizeof(int), in);
	for (int i = 0; i < nrop; i++) {
		fread(&op, 1, sizeof(int), in);
	}
}

void pow_man_un(sensor *sir_senzori, int i, FILE *in) {
	sir_senzori[i].sensor_data = malloc(sizeof(power_management_unit));
	power_management_unit *pmu = sir_senzori[i].sensor_data;
	float date; int date1;
	fread(&date, 1, sizeof(float), in); pmu->voltage = date;
	fread(&date, 1, sizeof(float), in); pmu->current = date;
	fread(&date, 1, sizeof(float), in); pmu->power_consumption = date;
	fread(&date1, 1, sizeof(int), in); pmu->energy_regen = date1;
	fread(&date1, 1, sizeof(int), in); pmu->energy_storage = date1;
	int nrop; int op;
	fread(&nrop, 1, sizeof(int), in); sir_senzori[i].nr_operations = nrop;
	sir_senzori[i].operations_idxs = malloc(sizeof(int) * nrop);
	for (int j = 0; j < nrop; j++) {
		fread(&op, 1, sizeof(int), in);
		sir_senzori[i].operations_idxs[j] = op;
	}
	sir_senzori[i].sensor_type = 1;
}

void tire_sens(sensor *sir_senzori, int i, FILE *in) {
	sir_senzori[i].sensor_data = malloc(sizeof(tire_sensor));
	tire_sensor *tire = sir_senzori[i].sensor_data;
	float date; int date1;
	fread(&date, 1, sizeof(float), in); tire->pressure = date;
	fread(&date, 1, sizeof(float), in); tire->temperature = date;
	fread(&date1, 1, sizeof(int), in); tire->wear_level = date1;
	fread(&date1, 1, sizeof(int), in); tire->performace_score = date1;
	int nrop; int op;
	fread(&nrop, 1, sizeof(int), in); sir_senzori[i].nr_operations = nrop;
	sir_senzori[i].operations_idxs = malloc(sizeof(int) * nrop);
	for (int j = 0; j < nrop; j++) {
		fread(&op, 1, sizeof(int), in);
		sir_senzori[i].operations_idxs[j] = op;
	}
	sir_senzori[i].sensor_type = 0;
}

void getinfo(sensor *sir_senzori, int nrsenzori, FILE *in) {
	int i = 0; int C_nrsenzori = nrsenzori;
	int tip_senzor;
	while (nrsenzori > 0) {
		fread(&tip_senzor, 1, sizeof(int), in);
		if (tip_senzor == 0) {
			salt2(in);
		} else {
			pow_man_un(sir_senzori, i, in);
			i++;
		}
		nrsenzori--;
	}
	fseek(in, 0, SEEK_SET);
	fread(&tip_senzor, 1, sizeof(int), in);
	while (C_nrsenzori > 0) {
		fread(&tip_senzor, 1, sizeof(int), in);
		if (tip_senzor == 0) {
			tire_sens(sir_senzori, i, in);
			i++;
		} else {
		 	salt1(in);
		}
		C_nrsenzori--;
	}
}

void printare(sensor *sir_senzori, int nrsenzori) {
	int i;
	scanf("%d", &i);
	if (i >= nrsenzori || i < 0) {
		printf("Index not in range!\n");
	} else {
		if (sir_senzori[i].sensor_type == 0) {
			printf("Tire Sensor\n");
			tire_sensor *tire = sir_senzori[i].sensor_data;
			printf("Pressure: %.2f\n", tire->pressure);
			printf("Temperature: %.2f\n", tire->temperature);
			printf("Wear Level: %d%%\n", tire->wear_level);
			if (tire->performace_score == 0)
				printf("Performance Score: Not Calculated\n");
			else
				printf("Performance Score: %d\n", tire->performace_score);
		} else {
			printf("Power Management Unit\n");
			power_management_unit *pmu = sir_senzori[i].sensor_data;
			printf("Voltage: %.2f\n", pmu->voltage);
			printf("Current: %.2f\n", pmu->current);
			printf("Power Consumption: %.2f\n", pmu->power_consumption);
			printf("Energy Regen: %d%%\n", pmu->energy_regen);
			printf("Energy Storage: %d%%\n", pmu->energy_storage);
		}
	}
}

void analyze(sensor *sir_senzori, int nrsenzori) {
	int i; scanf("%d", &i);
	if (i >= nrsenzori || i < 0) {
		printf("Index not in range!\n");
	} else {
		void (**ops)(void *) = malloc(8 * sizeof(void (*)(void *)));
		get_operations((void**)ops);
		for (int j = 0; j < sir_senzori[i].nr_operations; j++) {
			void *data = sir_senzori[i].sensor_data;
			ops[sir_senzori[i].operations_idxs[j]](data);
		}
		free(ops);
	}
}

void eliberare(sensor *sir_senzori, int nrsenzori) {
	for (int i = 0; i < nrsenzori; i++) {
		free(sir_senzori[i].sensor_data);
		free(sir_senzori[i].operations_idxs);
	}
	free(sir_senzori);
}

sensor *clean(sensor *sir_senzori, int *nrsenzori) {
	int j = 0;
	for (int i = 0; i < *nrsenzori; i++) {
		if (sir_senzori[i].sensor_type == 0) {
			tire_sensor *tire = sir_senzori[i].sensor_data;
			if ((tire->pressure >= 19 && tire->pressure <= 28) && (tire->temperature >= 0 && tire->temperature <= 120)
			&& (tire->wear_level >= 0 && tire->wear_level <= 100)) {
				j++;
			}
		} else {
			power_management_unit *pmu = sir_senzori[i].sensor_data;
			if ((pmu->voltage >= 10 && pmu->voltage <= 20) && (pmu->current >= -100 && pmu->current <= 100) 
			&& (pmu->power_consumption >= 0 && pmu->power_consumption <= 1000) && (pmu->energy_regen >= 0 
			&& pmu->energy_regen <= 100) && (pmu->energy_storage >= 0 && pmu->energy_storage <= 100)) {
				j++;
			}
		}
	}
	sensor *aux_senzori = malloc(j * sizeof(sensor)); j = 0;
	for (int i = 0; i < *nrsenzori; i++) {
		if (sir_senzori[i].sensor_type == 0) {
			tire_sensor *tire = sir_senzori[i].sensor_data;
			if ((tire->pressure >= 19 && tire->pressure <= 28) && (tire->temperature >= 0 && tire->temperature <= 120)
			&& (tire->wear_level >= 0 && tire->wear_level <= 100)) {
				aux_senzori[j].sensor_data = malloc(sizeof(tire_sensor));
				aux_senzori[j].operations_idxs = malloc(sizeof(int) * sir_senzori[i].nr_operations);
				tire_sensor *tire_aux = aux_senzori[j].sensor_data;
				tire_aux->performace_score = tire->performace_score;
				tire_aux->pressure = tire->pressure;
				tire_aux->temperature = tire->temperature;
				tire_aux->wear_level = tire->wear_level;
				aux_senzori[j].nr_operations = sir_senzori[i].nr_operations;
				for (int k = 0; k < sir_senzori[i].nr_operations; k++)
					aux_senzori[j].operations_idxs[k] = sir_senzori[i].operations_idxs[k];
				aux_senzori[j].sensor_type = 0;
				j++;
			}
		} else {
			power_management_unit *pmu = sir_senzori[i].sensor_data;
			if ((pmu->voltage >= 10 && pmu->voltage <= 20) && (pmu->current >= -100 && pmu->current <= 100) 
			&& (pmu->power_consumption >= 0 && pmu->power_consumption <= 1000) && (pmu->energy_regen >= 0 
			&& pmu->energy_regen <= 100) && (pmu->energy_storage >= 0 && pmu->energy_storage <= 100)) {
				aux_senzori[j].sensor_data = malloc(sizeof(power_management_unit));
				aux_senzori[j].operations_idxs = malloc(sizeof(int) * sir_senzori[i].nr_operations);
				power_management_unit *pmu_aux = aux_senzori[j].sensor_data;
				pmu_aux->power_consumption = pmu->power_consumption;
				pmu_aux->current = pmu->current;
				pmu_aux->energy_regen = pmu->energy_regen;
				pmu_aux->voltage = pmu->voltage;
				pmu_aux->energy_storage = pmu->energy_storage;
				aux_senzori[j].nr_operations = sir_senzori[i].nr_operations;
				for (int k = 0; k < sir_senzori[i].nr_operations; k++)
					aux_senzori[j].operations_idxs[k] = sir_senzori[i].operations_idxs[k];
				aux_senzori[j].sensor_type = 1;
				j++;
			}
		}
	}
	eliberare(sir_senzori, *nrsenzori);
	*nrsenzori = j;
	return aux_senzori;
}


int main(int argc, char const *argv[])
{
	if (argc <= 1)
		return -1;
	else {
		char *fisier = malloc(100 * sizeof(char));
		strcpy(fisier, argv[1]);

		FILE *in = fopen(fisier, "rb");
		int nrsenzori;
		fread(&nrsenzori, sizeof(int), 1, in);

		sensor *sir_senzori = (sensor*) malloc(sizeof(sensor) * nrsenzori);
		getinfo(sir_senzori, nrsenzori, in);

		fclose(in);
		char command[100];
    	scanf("%s", command);
		while (strcmp(command, "exit") != 0) {
			if (strcmp(command, "print") == 0)
				printare(sir_senzori, nrsenzori);
			if (strcmp(command, "analyze") == 0)
				analyze(sir_senzori, nrsenzori);
			if (strcmp(command, "clear") == 0)
				sir_senzori = clean(sir_senzori, &nrsenzori);
    		scanf("%s", command);
		}
		eliberare(sir_senzori, nrsenzori);
		free(fisier);
	}
	return 0;
}
