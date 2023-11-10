#!/bin/bash

REPO_NAME= ${{ github.repository }}
echo $REPO_NAME
exit
IS_SETUP=$(jq -r .repo .github/classroom/autograding.json)
        
        if [ "$IS_SETUP" != "$REPO_NAME" ]; then
          jq --arg rn "$REPO_NAME" '.repo = $rn' .github/classroom/autograding.json > tmp.json
          cat tmp.json > .github/classroom/autograding.json
          python3 .github/workflows/scripts/updateReadme.py

          # Commit and push changes
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add Readme.md .github/classroom/autograding.json
          git commit -m "Automatic setup"
          git push
        fi