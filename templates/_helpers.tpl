{{- define "lol-analysis.name" -}}lol-analysis{{- end }}
{{- define "lol-analysis.labels" -}}
app.kubernetes.io/name: {{ include "lol-analysis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: lol-analysis
{{- end }}
{{- define "lol-analysis.selector" -}}
app.kubernetes.io/name: {{ include "lol-analysis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
