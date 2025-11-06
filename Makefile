.PHONY: help install install-dev run test coverage format lint clean

help:  ## 显示帮助信息
	@echo "可用命令:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install:  ## 安装依赖
	uv sync

install-dev:  ## 安装开发依赖
	uv sync --extra dev

run:  ## 运行应用
	uv run python main.py

test:  ## 运行测试
	uv run --extra dev pytest

coverage:  ## 生成测试覆盖率报告
	uv run --extra dev pytest --cov=. --cov-report=html --cov-report=term

format:  ## 格式化代码
	uv run --extra dev black src/ tests/ main.py

lint:  ## 代码检查
	uv run --extra dev flake8 src/ tests/ main.py
	uv run --extra dev mypy src/

clean:  ## 清理临时文件
	rm -rf __pycache__ .pytest_cache .coverage htmlcov
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

.DEFAULT_GOAL := help

