# 1. Listar recursos
## Listar instancias
gcloud compute instances list

## Listar zonas disponibles
gcloud compute zones list

## Listar tipos de máquina
gcloud compute machine-types list

## Listar imágenes disponibles
gcloud compute images list

# 2. Crear instancias
gcloud compute instances create <NOMBRE> \
  --zone=us-central1-a \
  --machine-type=e2-medium \
  --image-family=debian-12 \
  --image-project=debian-cloud

# 3. Administrar instancias
## Detener instancia
gcloud compute instances stop <NOMBRE> --zone=us-central1-a

## Iniciar instancia
gcloud compute instances start <NOMBRE> --zone=us-central1-a

## Reiniciar instancia
gcloud compute instances reset <NOMBRE> --zone=us-central1-a

## Eliminar instancia
gcloud compute instances delete <NOMBRE> --zone=us-central1-a

#  4. Conexión y transferencia
## SSH
gcloud compute ssh <NOMBRE> --zone=us-central1-a

## Copiar archivo: local → VM
gcloud compute scp archivo.txt <NOMBRE>:~/ --zone=us-central1-a

## Copiar archivo: VM → local
gcloud compute scp <NOMBRE>:~/archivo.txt ./ --zone=us-central1-a

#  5. Discos
## Crear disco
gcloud compute disks create <DISCO> --size=50GB --zone=us-central1-a

## Adjuntar disco
gcloud compute instances attach-disk <NOMBRE> \
  --disk=<DISCO> --zone=us-central1-a

## Desconectar disco
gcloud compute instances detach-disk <NOMBRE> \
  --disk=<DISCO> --zone=us-central1-a

#  6. Snapshots e imágenes
## Crear snapshot
gcloud compute disks snapshot <DISCO> \
  --snapshot-name=<SNAP> \
  --zone=us-central1-a

## Crear imagen desde snapshot
gcloud compute images create <IMAGEN> \
  --source-snapshot=<SNAP>

#  7. Reglas de Firewall
## Listar reglas
gcloud compute firewall-rules list

## Crear regla HTTP
gcloud compute firewall-rules create permitir-http \
  --allow=tcp:80 \
  --target-tags=http-server

# 8. Plantillas y Managed Instance # Groups (MIG)
## Crear template
gcloud compute instance-templates create web-template \
  --machine-type=e2-medium \
  --image-family=debian-12 \
  --image-project=debian-cloud

## Crear grupo administrado
gcloud compute instance-groups managed create web-group \
  --base-instance-name=web \
  --size=2 \
  --template=web-template \
  --zone=us-central1-a
