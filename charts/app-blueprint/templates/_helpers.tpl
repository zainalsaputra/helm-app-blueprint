{{/* Expand the chart name. */}}
{{- define "app-blueprint.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create a fully qualified application name. */}}
{{- define "app-blueprint.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/* Chart name and version label. */}}
{{- define "app-blueprint.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Common labels. */}}
{{- define "app-blueprint.labels" -}}
helm.sh/chart: {{ include "app-blueprint.chart" . }}
{{ include "app-blueprint.selectorLabels" . }}
{{- with .Values.appVersionOverride }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Immutable selector labels. */}}
{{- define "app-blueprint.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app-blueprint.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* ServiceAccount name. */}}
{{- define "app-blueprint.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "app-blueprint.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* ConfigMap name. */}}
{{- define "app-blueprint.configMapName" -}}
{{- default (printf "%s-config" (include "app-blueprint.fullname" .)) .Values.configMap.name }}
{{- end }}

{{/* Secret name. */}}
{{- define "app-blueprint.secretName" -}}
{{- if .Values.secret.existingSecret }}
{{- .Values.secret.existingSecret }}
{{- else }}
{{- default (printf "%s-secret" (include "app-blueprint.fullname" .)) .Values.secret.name }}
{{- end }}
{{- end }}

{{/* Application image reference with optional digest pinning. */}}
{{- define "app-blueprint.image" -}}
{{- if .Values.image.digest }}
{{- printf "%s@%s" .Values.image.repository .Values.image.digest }}
{{- else }}
{{- printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) }}
{{- end }}
{{- end }}

{{/* Whether an environment source exists. */}}
{{- define "app-blueprint.hasEnvFrom" -}}
{{- if or .Values.configMap.create .Values.secret.create .Values.secret.existingSecret .Values.envFrom }}true{{- end }}
{{- end }}
