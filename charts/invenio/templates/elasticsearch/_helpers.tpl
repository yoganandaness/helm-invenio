{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "scicat-elastic-search.name" -}}
{{- default "elasticsearch" .Values.elasticsearch.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "scicat-elastic-search.fullname" -}}
{{- if .Values.elasticsearch.fullnameOverride -}}
{{- .Values.elasticsearch.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "elasticsearch" .Values.elasticsearch.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "scicat-elastic-search.chart" -}}
{{- printf "%s-%s" "elasticsearch" .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "scicat-elastic-search.labels" -}}
app.kubernetes.io/name: {{ include "scicat-elastic-search.name" . }}
helm.sh/chart: {{ include "scicat-elastic-search.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "scicat-elastic-search.serviceAccountName" -}}
{{- if .Values.elasticsearch.serviceAccount.create -}}
    {{ default (include "scicat-elastic-search.fullname" .) .Values.elasticsearch.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.elasticsearch.serviceAccount.name }}
{{- end -}}
{{- end -}}
