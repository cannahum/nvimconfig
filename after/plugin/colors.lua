function ColorMyPencils(color)
    print(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)
end

ColorMyPencils()
