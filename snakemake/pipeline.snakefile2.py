# program to run Species and MLST

#SAMPLES, = glob_wildcards('Assembly/{name}_unicycler.gte1kb.contigs.fasta') #Pull files which ends with fasta

SAMPLES, = glob_wildcards('Plasmids/{name}.fasta') #Pull files which ends with fasta

prokka_output = '2_PROKKA/{sample}_prokka_out/{sample}.gff'

# The input of rule all is the final output of the pipeline.
rule all:
  input: 
    "1_MLST/mlst_log", 
    expand(prokka_output, sample=SAMPLES), 
    expand('3_ROARY/{sample}.gff', sample=SAMPLES), 
    "3_ROARY/3_ROARY_OUTPUT/summary_statistics.txt"

rule run_MLST:
   # priority: 1
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify assemblies with a wildcard
    output: "1_MLST/mlst_log" # Need to specify MLST output with a wildcard
    shell: "mlst {input} >> {output}"

rule run_PROKKA:
   # priority: 2
    input: expand("Plasmids/{sample}.fasta", sample=SAMPLES) # Need to specify assemblies with a wildcard
    output: 
      "2_PROKKA/{sample}_prokka_out/{sample}.gff"
    threads: 32
    shell: "prokka2 --force --cpus {threads} --outdir 2_PROKKA/{wildcards.sample}_prokka_out --prefix {wildcards.sample} {input} >>2_PROKKA/prokka_log 2>>2_PROKKA/prokka_error"

rule cp_PROKKA_gffs:
  #priority: 3
  input: expand("2_PROKKA/{sample}_prokka_out/{sample}.gff", sample=SAMPLES)
  params:
    outdir= "3_ROARY" # For some reason instead of using {output}, using {params.outdir} worked in shell command
  output: "3_ROARY/{sample}.gff"
  shell: "cp {input} {params.outdir}"

rule run_ROARY:
    #priority: 4
    input: expand("3_ROARY/{sample}.gff", sample=SAMPLES) # Need to specify assemblies with a wildcard
    output: "3_ROARY/3_ROARY_OUTPUT/summary_statistics.txt" # Need to specify MLST output with a wildcard
    params:
      outdir = "3_ROARY/3_ROARY_OUTPUT"
    shell:
      'roary -f {params.outdir} -p 48 {input}'

