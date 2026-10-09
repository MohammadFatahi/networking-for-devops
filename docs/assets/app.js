(()=>{
  'use strict';
  const cards=[...document.querySelectorAll('.labcard')];
  const search=document.querySelector('#lab-search');
  const filters=[...document.querySelectorAll('.filter')];
  let group='all';
  let progress={};
  try{progress=JSON.parse(localStorage.getItem('networking-devops-progress')||'{}')}catch{}
  if(!progress||typeof progress!=='object')progress={};
  function updateProgress(){
    const count=document.querySelector('#progress');
    if(count)count.textContent=`${cards.filter(c=>c.querySelector('input').checked).length} / 12 labs marked complete on this device`;
  }
  cards.forEach(card=>{
    const check=card.querySelector('input');
    check.checked=!!progress[card.dataset.lab];
    check.addEventListener('change',()=>{
      progress[card.dataset.lab]=check.checked;
      try{localStorage.setItem('networking-devops-progress',JSON.stringify(progress))}catch{}
      updateProgress();
    });
  });
  function filterCards(){
    const query=(search?.value||'').toLowerCase().trim();
    let visible=0;
    cards.forEach(card=>{
      const match=(group==='all'||group===card.dataset.group)&&card.dataset.search.includes(query);
      card.hidden=!match;if(match)visible++;
    });
    const empty=document.querySelector('#empty');if(empty)empty.hidden=visible>0;
    const result=document.querySelector('#search-count');if(result)result.textContent=`${visible} labs shown`;
  }
  search?.addEventListener('input',filterCards);
  filters.forEach(button=>button.addEventListener('click',()=>{
    group=button.dataset.group;
    filters.forEach(b=>b.setAttribute('aria-pressed',String(b===button)));
    filterCards();
  }));
  document.querySelectorAll('.copy').forEach(button=>button.addEventListener('click',async()=>{
    try{await navigator.clipboard.writeText(button.parentElement.querySelector('code').textContent);button.textContent='Copied'}
    catch{button.textContent='Select code'}
    setTimeout(()=>{button.textContent='Copy'},1800);
  }));
  updateProgress();if(cards.length)filterCards();
})();
