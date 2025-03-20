*** Settings ***
Resource    hooks.robot
Resource    config.robot

Library     AppiumLibrary

#### Pages #####
Resource    ../pages/login_page.robot
Resource    ../pages/products_page.robot

#### Data #####
Variables   ../data/data.yaml