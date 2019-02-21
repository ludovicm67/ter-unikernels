.PHONY: report
report:
	pandoc --filter pandoc-citeproc -s report/meta.yml report/report.md -t latex -o report.pdf

.PHONY: clean
clean:
	$(RM) report.pdf
