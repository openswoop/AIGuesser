import discord
from discord.ext import commands
import requests
import openai
from dotenv import load_dotenv
import os
import subprocess


intents = discord.Intents.default()

intents.message_content = True
client = commands.Bot(intents=intents, command_prefix="$")
load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')
openai.api_key = os.getenv('OPENAI')
@client.command()
async def play(ctx):
    response = openai.Image.create(
    prompt=ctx.message.content,
    n=1,
    size="1024x1024"
    )
    image_url = response['data'][0]['url']
    embed=discord.Embed(title="", url=image_url, description="", color=0x1CEEEE)
    embed.set_thumbnail(url=image_url)
    
    await ctx.send(content=None, embed=embed)

@client.command()
async def info(ctx):
    await ctx.send("Made by Ra'Ed#2931")

@client.command()
async def users(ctx):
    await ctx.send(f"""This server has {id.member_count} members""")

client.run(TOKEN)