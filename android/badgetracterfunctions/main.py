import requests
import json
from bs4 import BeautifulSoup

profile_urls = [
'https://www.cloudskillsboost.google/public_profiles/3ccd4868-d3ab-4778-97c5-08e0db4bb8f1',
'https://www.cloudskillsboost.google/public_profiles/e8aeb016-c0b6-458a-be24-9906dc5c5ab4',
'https://www.cloudskillsboost.google/public_profiles/1978d95d-b6af-4a61-9961-761e2f7cd45f',
'https://www.cloudskillsboost.google/public_profiles/edc85fcb-9478-4b79-b311-01451e5ec77f'
]

def get_badges(request):

    payload = []

    for url in profile_urls:
        response = requests.get(url)

        soup = BeautifulSoup(response.text, 'html.parser')

        badges = process_badges(soup)
        user_profile = process_user(soup)

        if user_profile['name'] != '':
            user_payload = {
                'badges': badges,
                'profile': user_profile
            }

            payload.append(user_payload)

    return json.dumps(payload), 200, {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json'
    }

def process_user(soup):
    user = {
        'name': '',
        'member_since': '',
        'avatar': ''
    }

    try:
        root_container = soup.find('main', attrs={'id': 'jump-content'})
        avatar_container = root_container.find('div', { 'class': 'text--center'})
        avatar = avatar_container.find('ql-avatar', { 'class': 'l-mbl'})
        user['avatar'] = avatar_container.find('ql-avatar', { 'class': 'l-mbl'})['src']
        user['name'] = avatar_container.find('h1', { 'class': 'ql-headline-1'}).text.strip()
        user['member_since'] = avatar_container.find('p', { 'class': 'ql-body-1'}).text.strip()
    except:
        user['avatar'] = 'https://www.gstatic.com/images/branding/product/2x/avatar_anonymous_512dp.png'

    return user

def process_badges(soup):
    profile_badges_container = soup.find('div', attrs={'class': 'profile-badges'})
    profile_badges_list = []

    try:
        profile_badges = profile_badges_container.findAll('div', { 'class': 'profile-badge'})

        for badge in profile_badges:
            badge_dic = {}
            badge_dic['badgeTitle'] = badge.find('span', { 'class': 'ql-subhead-1'}).text.strip()
            badge_dic['link'] = badge.find('a', { 'class': 'badge-image'})['href']
            badge_dic['earned'] = badge.find('span', { 'class': 'ql-body-2'}).text.strip()
            profile_badges_list.append(badge_dic)
    except:
        profile_badges_list = []

    return profile_badges_list