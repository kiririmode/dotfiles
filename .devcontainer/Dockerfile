FROM mcr.microsoft.com/devcontainers/python:3.12-bookworm

# Install system dependencies including Node.js
RUN rm -f /etc/apt/sources.list.d/yarn.list \
    apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*

# Switch to vscode user and install uv, pre-commit
USER vscode
RUN mkdir -p $HOME/.claude \
    && curl -LsSf https://astral.sh/uv/install.sh | sh \
    && $HOME/.local/bin/uv tool install pre-commit
# RUN npm install -g @anthropic-ai/claude-code

# Set working directory
WORKDIR /workspaces/dotfiles

# Set default shell
SHELL ["/bin/bash", "-c"]
