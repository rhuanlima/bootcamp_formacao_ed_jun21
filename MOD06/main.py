#%%
from selenium import webdriver
import sys
import time
#%%
cep =  sys.argv[1]

if cep:
    driver  = webdriver.Chrome('./src/chromedriver')
    time.sleep(10)
    #%%
    # Acesso ao site da How
    # driver.get('https://howedu.com.br/')
    # driver.find_element_by_xpath('//*[@id="PopupSignupForm_0"]/div[2]/div[1]').click()
    # driver.find_element_by_xpath('/html/body/section[4]/div/div/div[2]/a').click()
    # %%
    driver.get('https://buscacepinter.correios.com.br/app/endereco/index.php?t')
    elem_cep = driver.find_element_by_name('endereco')
    #%%
    elem_cep.clear()
    # %%
    elem_cep.send_keys('80420130')
    # %%
    elem_cmb = driver.find_element_by_name('tipoCEP')
    elem_cmb.click()
    driver.find_element_by_xpath(
        '//*[@id="formulario"]/div[2]/div/div[2]/select/option[6]').click()
    # %%
    driver.find_element_by_id('btn_pesquisar').click()
    # %%
    logradouro = driver.find_element_by_xpath(
        '/html/body/main/form/div[1]/div[2]/div/div[3]/table/tbody/tr/td[1]').text
    bairro = driver.find_element_by_xpath(
        '//*[@id="resultado-DNEC"]/tbody/tr/td[2]').text
    localidade = driver.find_element_by_xpath(
        '/html/body/main/form/div[1]/div[2]/div/div[3]/table/tbody/tr/td[3]').text

    driver.close()
    # %%
    print("""
    Para o CEP {} temos:

    Endereço: {}
    Bairro: {}
    Localidade: {}
    """.format(
    cep,
    logradouro.split(' - ')[0],
    bairro,
    localidade
    ))
# %%

